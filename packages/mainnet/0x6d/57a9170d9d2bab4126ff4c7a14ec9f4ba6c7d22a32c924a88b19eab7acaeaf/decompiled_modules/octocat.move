module 0x6d57a9170d9d2bab4126ff4c7a14ec9f4ba6c7d22a32c924a88b19eab7acaeaf::octocat {
    struct OCTOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOCAT>(arg0, 6, b"OCTOCAT", b"GitHub's Mascot Octocat Sui", b"An Octocat is a mythical creature that blends the characteristics of an octopus and a cat. This playful and curious creature is often depicted with eight arms and cat-like features, making it a unique and memorable mascot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241224_030735_348_1ddd9c89ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

