module 0xf1e6e09de7ddffc792f56f751cac85278cc73dc5995ea4b864dd8c5f93a911da::iash {
    struct IASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: IASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IASH>(arg0, 6, b"IASH", b"I'm Super High", b"im super high and i just love sui so idk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_1583160247711_2191776b4b91_f0f8142b26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

