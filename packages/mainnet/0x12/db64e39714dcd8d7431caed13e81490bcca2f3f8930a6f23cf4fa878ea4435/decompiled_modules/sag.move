module 0x12db64e39714dcd8d7431caed13e81490bcca2f3f8930a6f23cf4fa878ea4435::sag {
    struct SAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAG>(arg0, 6, b"SAG", b"SUIRREL AND GUN", b"[CTO] Shoot all the jeeters and make it in BlueMove Dex!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2058_252b5642f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

