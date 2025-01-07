module 0x4e82da676f12104adb3903c1d145318b9d33539d8aa6e8e1447e36143f79a658::ju {
    struct JU has drop {
        dummy_field: bool,
    }

    fun init(arg0: JU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JU>(arg0, 6, b"JU", b"Jungle juice", b"Jungle juice is an improvised mix of liquor that is usually served for group consumption.[1] There are countless recipes and even websites devoted solely to jungle juice. The term has also been used for similar less-than-reputable alcoholic concoctions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1901_ae680f557b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JU>>(v1);
    }

    // decompiled from Move bytecode v6
}

