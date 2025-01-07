module 0x124407990dd73bd8f5dc29c58fe9428e07f5e932a65b391e1e164f8e42f72193::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOP>(arg0, 9, b"HOP", b"HOPPY", b"HOPPY is a vibrant cryptocurrency designed for fun and engagement within the crypto community. With a focus on rewarding users for participation, it enables easy transactions, fosters playful interactions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ba6ff38-334d-4d3b-a0d9-75241b9ccc0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

