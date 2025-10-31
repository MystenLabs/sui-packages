module 0x184fe9e31fb8d436a29408570af93c44920a56294b0d0aab500ca419d0ec74b3::mmt {
    struct MMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMT>(arg0, 9, b"MMT", b"Momentum", x"4d6f6d656e74756d20697320746865206c656164696e6720444558206f6e205375692c206f66666572696e6720746f70204150527320666f72204c50732e20506f77657265642062792074686520766528332c3329206d6f64656c206174205447452c206974e2809973206275696c7420746f2062652074686520636f7265206c697175696469747920656e67696e65206f6620746865205375692065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.bgstatic.com/multiLang/web/10496ac4ac31f8e5643227005d536953.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MMT>>(0x2::coin::mint<MMT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MMT>>(v2);
    }

    // decompiled from Move bytecode v6
}

