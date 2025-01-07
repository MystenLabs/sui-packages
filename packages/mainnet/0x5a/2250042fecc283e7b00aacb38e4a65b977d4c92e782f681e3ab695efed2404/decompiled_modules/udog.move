module 0x5a2250042fecc283e7b00aacb38e4a65b977d4c92e782f681e3ab695efed2404::udog {
    struct UDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UDOG>(arg0, 6, b"UDOG", b"Underdog", b"Underdog is the greatest meme coin ever created. Please join me on this journey to the moon. We plan to launch a stable coin in the future backed by gold and so much more..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725930444396_38e16423610c4f203e1c9c045bd22ac8_0d845991e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

