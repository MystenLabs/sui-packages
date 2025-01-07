module 0xb6be1aa052b43d18e5bb523e95bd6bf6cfa9ab00b4109d00f63756cf50f3401f::graph {
    struct GRAPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAPH>(arg0, 9, b"GRAPH", b"Graphy", b"a quick node for graph", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e425dce1-600f-4860-957a-948944d3dc51.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRAPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

