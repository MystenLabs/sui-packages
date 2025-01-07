module 0x7575c9d21e236b5532eca0e9df6f06c24ccb6b7e04a3e90580ed1ff48d5797e8::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOP>(arg0, 6272405691970181709, b"HOPIUM", b"HOP", x"596f2c206a75737420766962696ee2809920616c6f6e672077697468206d792024484f5049554d207768656e2073756464656e6c792e2e2e20f09f94a52057686f612c2067756573732074686174e280990a546865207469636b65722069732024484f5049554d3a204765742052696368206f722043727920547279696e67210a53554920504c414e455420686f7069756d7375692e636f6d0a68747470733a2f2f782e636f6d2f686f7069756d66756e", b"https://images.hop.ag/ipfs/QmTU6SxB4HP68FNZHTVYakEQ66GniG3tYXtYr2YYcKwT44", 0x1::string::utf8(b"https://x.com/hopiumfun"), 0x1::string::utf8(b"https://www.hopiumsui.com/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

