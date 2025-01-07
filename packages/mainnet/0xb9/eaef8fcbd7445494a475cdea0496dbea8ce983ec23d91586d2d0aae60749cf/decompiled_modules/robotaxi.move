module 0xb9eaef8fcbd7445494a475cdea0496dbea8ce983ec23d91586d2d0aae60749cf::robotaxi {
    struct ROBOTAXI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ROBOTAXI>, arg1: 0x2::coin::Coin<ROBOTAXI>) {
        0x2::coin::burn<ROBOTAXI>(arg0, arg1);
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ROBOTAXI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ROBOTAXI>(arg0, arg1, arg2, arg3);
    }

    entry fun add_blacklist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ROBOTAXI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ROBOTAXI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ROBOTAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ROBOTAXI>(arg0, 6, b"Robotaxi", b"Tesla Robotaxi", b"Elon's Tesla RoboTaxi - $ROBOTAXII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://silver-urgent-porpoise-620.mypinata.cloud/ipfs/QmYyjBLXMkGn3uxo53kKSJDRZTAgkFJbTct1ButT1tkcjJ"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ROBOTAXI>(&mut v3, 10000000000000000, @0xf63bcd9bbe98125868d66becca64a3c09c3dac286e44fbfb34c6210b14aad890, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROBOTAXI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOTAXI>>(v3, @0x346024e3e6273cdb98d333062e76d781584c3ee1d1a701643fd950a5e9a2a179);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ROBOTAXI>>(v1, @0x346024e3e6273cdb98d333062e76d781584c3ee1d1a701643fd950a5e9a2a179);
    }

    entry fun unblock_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ROBOTAXI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ROBOTAXI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

