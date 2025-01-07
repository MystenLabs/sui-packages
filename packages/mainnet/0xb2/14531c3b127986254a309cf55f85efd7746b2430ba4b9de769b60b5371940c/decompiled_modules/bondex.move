module 0xb214531c3b127986254a309cf55f85efd7746b2430ba4b9de769b60b5371940c::bondex {
    struct BONDEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONDEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONDEX>(arg0, 9, b"BONDEX", b"Bondex app", b"0x8d46f785063cf0965a5b6a5dd5d4f45fe5a7125ef5a9fe155ec89cc5ba7c10e5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30b8bf25-dca0-4469-9174-1dcae46f08fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONDEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONDEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

