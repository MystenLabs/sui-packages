module 0xf7866a1e19e9fa51dd13ba0c84f96e2b3d2a16af4a4eed9207d361a2ce553cef::dontsell {
    struct DONTSELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONTSELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTSELL>(arg0, 6, b"Dontsell", b"DONTSELL", x"24444f4e5453454c4c2069736ee2809974206a757374206120746f6b656e3b206974e2809973206120776179206f66206c6966652e20496e2061206d61726b65742066756c6c206f662070617065722068616e64732c207765207374616e64206669726d2c207374726f6e672c20616e6420756e7368616b61626c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736255061720.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONTSELL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTSELL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

