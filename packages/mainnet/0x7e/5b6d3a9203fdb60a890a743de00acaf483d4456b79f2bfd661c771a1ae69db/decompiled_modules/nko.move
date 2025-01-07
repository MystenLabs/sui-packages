module 0x7e5b6d3a9203fdb60a890a743de00acaf483d4456b79f2bfd661c771a1ae69db::nko {
    struct NKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NKO>(arg0, 6, b"NKO", b"NEKO", x"244e454b4f20656d626f6469657320746865207065726665637420667573696f6e206f6620616e696d652063756c747572652c20626c6f636b636861696e20746563686e6f6c6f67792c20616e6420646563656e7472616c697a656420696e6e6f766174696f6e2e20496e7370697265642062792074686520636861726d20616e642061646170746162696c697479206f662066656c696e65207472616974732c20244e454b4f206973206d6f7265207468616e206120746f6b656ee28094697427732061206761746577617920746f206120756e697665727365206f6620706f73736962696c69746965732e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733595823283.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NKO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

