module 0x2a5fdaac163707ff266f1f60a00214cf99babd263b436cad30a180662f39514f::suipx {
    struct SUIPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPX>(arg0, 9, b"SUIPX", b"SuiPX6900", b"You know what this means", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1785978621535916032/ZYZIK4ZP.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPX>(&mut v2, 700000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

