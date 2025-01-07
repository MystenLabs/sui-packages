module 0xdaba461de88360681088663621c7f9b74567aada30b307e071fca3ffa3d24202::b5 {
    struct B5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B5>(arg0, 9, b"B5", b"Dudu", b"Meme for every kid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62d5d646-4431-44a3-b8d9-c074ba4cf72f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B5>>(v1);
    }

    // decompiled from Move bytecode v6
}

