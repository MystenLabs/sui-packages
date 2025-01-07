module 0x728c1f70baecc9bf5287908b6202ec0d74c760f63068d9537de8b46c97705d63::mst {
    struct MST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MST>(arg0, 9, b"MST", b"MemeStash", x"596f7572206d656d657320617265206e6f7720776f727468206d6f7265207468616e206c696b657321204d656d6553746173682069732077686572652074686520696e7465726e6574e28099732066756e6e6965737420636f6e74656e742067657473207472616e73666f726d656420696e746f207265616c2d776f726c642076616c75652e204a6f696e207468652073746173682c20616e64206c657420746865206d656d657320666c6f7721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fad2291b-39f9-46b5-a692-20590dab22be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MST>>(v1);
    }

    // decompiled from Move bytecode v6
}

