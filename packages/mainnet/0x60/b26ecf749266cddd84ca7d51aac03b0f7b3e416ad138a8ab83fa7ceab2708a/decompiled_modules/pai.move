module 0x60b26ecf749266cddd84ca7d51aac03b0f7b3e416ad138a8ab83fa7ceab2708a::pai {
    struct PAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAI>(arg0, 6, b"PAI", b"Panda AI", b"Panda AI, where cutting-edge AI meets blockchain innovation! Panda AI combines the timeless appeal of pandas with advanced technology to create a unique cryptocurrency that drives profitability, community success, and smart investments", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736216720379.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

