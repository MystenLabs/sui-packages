module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt {
    struct BKT has drop {
        dummy_field: bool,
    }

    struct BktTreasury has key {
        id: 0x2::object::UID,
        eco_part: 0x2::balance::Balance<BKT>,
        bkt_supply: 0x2::balance::Supply<BKT>,
    }

    struct BktAdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun amount_of(arg0: u64) : u64 {
        arg0 * 1000
    }

    public fun collect_bkt(arg0: &mut BktTreasury, arg1: 0x2::balance::Balance<BKT>) {
        0x2::balance::join<BKT>(&mut arg0.eco_part, arg1);
    }

    public fun get_eco_part_balance(arg0: &BktTreasury) : u64 {
        0x2::balance::value<BKT>(&arg0.eco_part)
    }

    fun init(arg0: BKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_treasury(arg0, arg1);
        0x2::transfer::share_object<BktTreasury>(v0);
        0x2::transfer::transfer<BktAdminCap>(v1, @0x169451f78c5f099a57b0126902a7e61a0c9dace2a8e40caa16168e874d0f0156);
    }

    fun new_treasury(arg0: BKT, arg1: &mut 0x2::tx_context::TxContext) : (BktTreasury, BktAdminCap) {
        let (v0, v1) = 0x2::coin::create_currency<BKT>(arg0, 3, b"BKT", b"Bucket Token", b"the utility token of bucketprotocol.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRfNHXUBoeCczQexM2vzYzCM11tyovW1ZmTsb4ZMc1poj")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BKT>>(0x2::coin::mint<BKT>(&mut v2, amount_of(100000000 - 30000000), arg1), @0x169451f78c5f099a57b0126902a7e61a0c9dace2a8e40caa16168e874d0f0156);
        let v3 = 0x2::coin::treasury_into_supply<BKT>(v2);
        assert!(0x2::balance::supply_value<BKT>(&v3) == amount_of(100000000), 0);
        let v4 = BktTreasury{
            id         : 0x2::object::new(arg1),
            eco_part   : 0x2::coin::mint_balance<BKT>(&mut v2, amount_of(30000000)),
            bkt_supply : v3,
        };
        let v5 = BktAdminCap{id: 0x2::object::new(arg1)};
        (v4, v5)
    }

    public(friend) fun release_bkt(arg0: &mut BktTreasury, arg1: u64) : 0x2::balance::Balance<BKT> {
        0x2::balance::split<BKT>(&mut arg0.eco_part, arg1)
    }

    public fun withdraw_treasury(arg0: &BktAdminCap, arg1: &mut BktTreasury, arg2: u64) : 0x2::balance::Balance<BKT> {
        0x2::balance::split<BKT>(&mut arg1.eco_part, arg2)
    }

    entry fun withdraw_treasury_to(arg0: &BktAdminCap, arg1: &mut BktTreasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BKT>>(0x2::coin::from_balance<BKT>(withdraw_treasury(arg0, arg1, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

