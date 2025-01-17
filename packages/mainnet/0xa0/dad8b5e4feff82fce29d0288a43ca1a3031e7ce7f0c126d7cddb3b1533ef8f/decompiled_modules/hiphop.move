module 0xa0dad8b5e4feff82fce29d0288a43ca1a3031e7ce7f0c126d7cddb3b1533ef8f::hiphop {
    struct HIPHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPHOP>(arg0, 6, b"HIPHOP", b"Hiphop", x"486f70206f6e746f20537569202620666169726c61756e6368206120636f696e20696e7374616e746c792077697468206a757374206120636f75706c65206f6620636c69636b732e0a0a466173742c20536166652c20467265653a20476f6f642074656b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xxx_766b37ac6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

