module 0x415f957fbe38d0035784544c25eb746b53bca28190b401a222641154ccc9f18b::aibot {
    struct AIBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIBOT>(arg0, 9, b"AIBOT", b"Ai boots", b"Aibot everywhere , how could you escape. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5f9749e-a453-4e0b-b3e8-e1de9cc3a8df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

