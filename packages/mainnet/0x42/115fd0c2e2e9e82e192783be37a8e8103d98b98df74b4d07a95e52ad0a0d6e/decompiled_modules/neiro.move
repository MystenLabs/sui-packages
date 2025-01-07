module 0x42115fd0c2e2e9e82e192783be37a8e8103d98b98df74b4d07a95e52ad0a0d6e::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 6, b"NEIRO", b"Neiro On SUI", x"4e6569726f206f6e205375692028244e4549524f290a0a4e6569726f206c61756e6368696e67206f6e207468652053756920626c6f636b636861696e20617320446f6765277320737563636573736f722e20244e4549524f20697320726561647920746f2074616b65206f766572205355492c206c65642062792061207465616d207769746820657870657269656e636520696e206d756c74692d6d696c6c696f6e20646f6c6c61722070726f6a656374732e204a6f696e20746865206d6f76656d656e7420616e642062652070617274206f662074686520667574757265206f66206d656d6520636f696e73207769746820244e4549524f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9692_c758afa043.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

