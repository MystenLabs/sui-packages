module 0x73ff9eb7714e8d1635f6476678d52f87ee86ed850803ce40c0b07aaa43bb8788::krp {
    struct KRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRP>(arg0, 9, b"KRP", b"Kasparov", x"4b61737061726f7620546f6b656e3a20496e73706972656420627920746865206368657373206c6567656e642c204b61737061726f7620546f6b656e206272696e677320737472617465677920746f2063727970746f21204974e280997320612066756e206d656d6520746f6b656e20666f722074726164657273206c6f6f6b696e6720746f206d616b6520626f6c64206d6f7665732e204a6f696e20696e2c20737461636b20757020796f757220746f6b656e732c20616e642061696d20746f20636865636b6d61746520746865206d61726b65742077697468204b61737061726f7620546f6b656e2120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5497667-ef6e-4772-ad85-0678c932a62e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

