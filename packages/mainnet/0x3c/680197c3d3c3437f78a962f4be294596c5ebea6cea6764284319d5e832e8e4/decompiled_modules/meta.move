module 0x3c680197c3d3c3437f78a962f4be294596c5ebea6cea6764284319d5e832e8e4::meta {
    struct META has drop {
        dummy_field: bool,
    }

    struct Treasury has store, key {
        id: 0x2::object::UID,
        meta: 0x2::balance::Balance<META>,
    }

    public(friend) fun mint(arg0: &mut Treasury, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<META>(&arg0.meta) > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<META>>(0x2::coin::from_balance<META>(0x2::balance::split<META>(&mut arg0.meta, arg2), arg3), arg1);
    }

    public fun decimals() : u8 {
        9
    }

    public fun destroy_treasury(arg0: Treasury) {
        assert!(0x2::balance::value<META>(&arg0.meta) == 0, 2);
        let Treasury {
            id   : v0,
            meta : v1,
        } = arg0;
        0x2::balance::destroy_zero<META>(v1);
        0x2::object::delete(v0);
    }

    fun init(arg0: META, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<META>(arg0, 9, b"META", b"META", b"META", 0x1::option::some<0x2::url::Url>(0x3c680197c3d3c3437f78a962f4be294596c5ebea6cea6764284319d5e832e8e4::icon::get_icon_url()), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<META>>(v3, 0x2::object::id_address<0x2::coin::CoinMetadata<META>>(&v2));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<META>>(v2);
        let v4 = Treasury{
            id   : 0x2::object::new(arg1),
            meta : 0x2::coin::into_balance<META>(0x2::coin::mint<META>(&mut v3, 21000000000000000, arg1)),
        };
        0x2::transfer::public_share_object<Treasury>(v4);
    }

    // decompiled from Move bytecode v6
}

