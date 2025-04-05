module 0x8afe8f5e696b15aa97ccf231ea9293c8f1fffe345e2a2f3941fede5f11ecfc0::fshi {
    struct FSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSHI>(arg0, 9, b"Fshi", b"sky", b"zhendeyingxionh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/66311b7ce2dc6e31ea16c9dfa653b6c7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

