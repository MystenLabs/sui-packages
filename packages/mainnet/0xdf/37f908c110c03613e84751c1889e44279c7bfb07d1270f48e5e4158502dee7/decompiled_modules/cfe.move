module 0xdf37f908c110c03613e84751c1889e44279c7bfb07d1270f48e5e4158502dee7::cfe {
    struct CFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFE>(arg0, 9, b"CFE", b"coffee", x"5065726b20757020796f757220706f7274666f6c696f207769746820436f66666565436f696e3a205468652061726f6d617469632063727970746f63757272656e63792062726577696e672070726f6669747320616e6420656e657267697a696e67207468652063727970746f20776f726c642c206f6e652063757020617420612074696d6520e29895", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/352400fa-66ce-4a50-b897-c998727c9842.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

