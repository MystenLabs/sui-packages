module 0xa525d4f99cfe300f34f75838ab1347f6fb554fff599325db71881ace8f09b90b::npc {
    struct NPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPC>(arg0, 9, b"NPC", b"Non Payble", b"It is a meme token which firrenciat Non Payble character.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/28f47956-2881-47da-9be5-fc2ba6293d56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

