module 0x5f891226f0db508375bae90175db2d2b56ede2702d4467e0a1f2cb82d59ee343::dewy {
    struct DEWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEWY>(arg0, 6, b"DEWY", b"DEWY ON SUI", b"$DEWY is a for-fun memecoin launched on the SUI network. There is no utility or functionality associated with the token. It's a community driven mascot with the mission to spread fun, joy and awareness across SUI. The fictional character behind DEWY is a blue blob that used to live in the ocean and is now trying to become land born in order to spread the knowledge of crypto to the general public. DEWY also enables a safe place via community chats to learn more about crypto, foster friendship through the mascot and more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_3_8a3f83d727.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

