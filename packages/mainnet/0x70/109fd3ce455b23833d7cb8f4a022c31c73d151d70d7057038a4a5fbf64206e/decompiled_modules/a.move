module 0x70109fd3ce455b23833d7cb8f4a022c31c73d151d70d7057038a4a5fbf64206e::a {
    struct A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A>(arg0, 9, b"A", b"Art", x"5468697320636f696e206973206177617264656420746f2074686f73652077686f2063616e2063726561746520616e64206465706963742062656175746966756c207069637475726573206f66206e61747572650a4e61747572616c20696d61676573206f7220696d61676573206d6164652077697468206172746966696369616c20696e74656c6c6967656e636520616e642074686520636f6d62696e6174696f6e206f662064657369676e20617274", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/92f5a0bb-bd6b-4166-99a7-9985c8d84a22.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A>>(v1);
    }

    // decompiled from Move bytecode v6
}

