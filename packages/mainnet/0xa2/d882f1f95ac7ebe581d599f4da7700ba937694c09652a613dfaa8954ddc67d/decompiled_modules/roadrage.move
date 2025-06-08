module 0xa2d882f1f95ac7ebe581d599f4da7700ba937694c09652a613dfaa8954ddc67d::roadrage {
    struct ROADRAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROADRAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROADRAGE>(arg0, 9, b"rdrg", b"roadrage", b"move bitch. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/365a7239-1ab1-428c-b168-6eaa843722b4.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROADRAGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROADRAGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

