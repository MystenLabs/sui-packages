module 0x889243021e9bf18b46a72df12122f79600ef9e6af65eaf9f584658c70fda4a64::u {
    struct U has drop {
        dummy_field: bool,
    }

    fun init(arg0: U, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<U>(arg0, 6, b"U", b"Magnet of Sui", b"Magnet of Sui is the strongest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_02_17_36_56707ee5f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<U>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<U>>(v1);
    }

    // decompiled from Move bytecode v6
}

