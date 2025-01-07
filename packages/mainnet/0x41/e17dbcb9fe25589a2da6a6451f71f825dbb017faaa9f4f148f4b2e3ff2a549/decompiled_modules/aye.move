module 0x41e17dbcb9fe25589a2da6a6451f71f825dbb017faaa9f4f148f4b2e3ff2a549::aye {
    struct AYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYE>(arg0, 6, b"AYE", b"KOYO", x"4465617220417965204b6f796f20436f6d6d756e697479210a0a546865206d6f6d656e74207765766520616c6c206265656e2077616974696e6720666f722069732066696e616c6c792068657265210a0a57657265206578636974656420746f20616e6e6f756e6365207468617420746865206f6666696369616c206c61756e6368206f6620244159452069732068617070656e696e673a0a0a4672696461792c204f63742031312061742032504d20555443202f203130414d204553540a0a5468652043412077696c6c20626520706f7374656420616e642070696e6e6564206f6e205820616e642054472e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018253_cbc69381d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

