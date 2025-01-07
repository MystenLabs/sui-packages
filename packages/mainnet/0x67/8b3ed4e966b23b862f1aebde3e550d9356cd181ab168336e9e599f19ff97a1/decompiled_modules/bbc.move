module 0x678b3ed4e966b23b862f1aebde3e550d9356cd181ab168336e9e599f19ff97a1::bbc {
    struct BBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBC>(arg0, 9, b"BBC", b"black man", b"BAY FOR YOU SELF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc63f956-b737-48ee-b54c-cd770924f644.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

