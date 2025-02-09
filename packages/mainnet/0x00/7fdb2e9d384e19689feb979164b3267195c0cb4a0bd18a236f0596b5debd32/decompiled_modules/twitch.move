module 0x7fdb2e9d384e19689feb979164b3267195c0cb4a0bd18a236f0596b5debd32::twitch {
    struct TWITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWITCH>(arg0, 6, b"TWITCH", b"Twitch", x"5477697463682070616e696373206174206576657279206469702c206f7665727468696e6b732065766572792070756d702c20616e64207265667265736865732044657873637265656e65722065766572792066697665207365636f6e64732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_Ty26_D_3_400x400_544382708e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

