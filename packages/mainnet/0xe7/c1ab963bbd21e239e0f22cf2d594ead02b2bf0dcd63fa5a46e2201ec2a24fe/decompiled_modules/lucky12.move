module 0xe7c1ab963bbd21e239e0f22cf2d594ead02b2bf0dcd63fa5a46e2201ec2a24fe::lucky12 {
    struct LUCKY12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKY12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKY12>(arg0, 9, b"LUCKY12", b"LUCKY", x"57656c636f6d6520746f2074686520776f726c64206f66204c75636b792047617264656e20f09f98b82077686572652074686520224c75636b79204361742220646f65736e277420206a757374206272696e672070726f737065726974792062757420616c736f20706c616e74207472656173757265732120f09f8cb1204a75737420706c616e7420736565647320616e64207761746368206d6f6e65792074726565732067726f772066726f6d207468652067726f756e64206c696b65206d6167696321202041726520796f7520726561647920746f2063726561746520796f7572206c75636b792067617264656e3f20f09f8d80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5641648-167b-44d1-8e7e-16020c818ee0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKY12>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCKY12>>(v1);
    }

    // decompiled from Move bytecode v6
}

