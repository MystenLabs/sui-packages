module 0xa07531a18e72f1e02cb714dcebce4aeb33e9fd32ceca036091091448c7ed3568::moonsui {
    struct MOONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONSUI>(arg0, 9, b"MOONSUI", b"SUI TO  THE MOON", x"20546865206d656d6520636f696e2074686174e2809973206f76657220746865206d6f6f6ee280946c69746572616c6c792120506f7765726564206279207468652053756920626c6f636b636861696e2c204d6f6f6e5375692061696d7320746f20726f636b657420796f75722077616c6c6574207768696c65206c656176696e6720796f757220667269656e647320776f6e646572696e6720696620746865792073686f756c642062757920612074656c6573636f706520746f20747261636b20697473207472616a6563746f72792e204f6e6520736d616c6c207374657020666f72205375692c206f6e65206769616e74206c65617020666f72206d656d65732120f09f9a80f09f8c95", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f0b9238d052002c63ee128ddcd4dbaf4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

