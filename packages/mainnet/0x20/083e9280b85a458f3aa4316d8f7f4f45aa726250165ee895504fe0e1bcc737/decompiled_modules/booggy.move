module 0x20083e9280b85a458f3aa4316d8f7f4f45aa726250165ee895504fe0e1bcc737::booggy {
    struct BOOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOGGY>(arg0, 6, b"BOOGGY", b"BOOGGY SUI", x"426f6f6767792c20776173206f6e6365206120646567656e206d656d65636f696e2067616d626c65722c206a757374206c696b6520796f752e0a4166746572206265696e67207275672d70756c6c6564206f6e6520746f6f206d616e792074696d6573206865206465636964656420746f2063726561746520686973206f776e20756e6971756520746f6b656e2e0a5468652062696720646966666572656e63653f205472616e73706172656e63792026205068696c616e7468726f70792e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bynznk2d_400x400_7b44bcf7fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

