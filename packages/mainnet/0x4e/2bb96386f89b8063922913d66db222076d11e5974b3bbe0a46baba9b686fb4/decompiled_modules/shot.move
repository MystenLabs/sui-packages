module 0x4e2bb96386f89b8063922913d66db222076d11e5974b3bbe0a46baba9b686fb4::shot {
    struct SHOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOT>(arg0, 6, b"SHOT", b"PopShot On Sui", x"616e6f74686572206461792c20616e64206f6e65206d6f7265202453484f540a0a47657420796f75722073636f72657320696e21204c6561646572626f61726420686173206265656e2072657365742c20616e6420667265736820706f696e74732061726520796f75727320666f72207468652074616b696e672120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250430_002250_e70e9a3c30.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

