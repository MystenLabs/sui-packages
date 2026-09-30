module 0x76ff6fc5daa034e3c729fc709bc49df19ed8d8372d0647804c13027f2dbec1f::olf {
    struct OLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<OLF>(arg0, 6, 0x1::string::utf8(b"OLF"), 0x1::string::utf8(b"Onlyfans"), 0x1::string::utf8(x"4c657427732067657420667265656b792e200a466972737420746f6b656e697a6564207072697661746520617373657320746f20796f7572206661766f726974652066656d616c652e0a4461696c79206275796261636b20616e64206275726e2e"), 0x1::string::utf8(b"https://popularsui.xyz/media/f311c5e7ae9b9979cb642ab92dcb6125917bfa46ecad1f1b80729250f87a9f0a.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLF>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<OLF>>(0x2::coin_registry::finalize<OLF>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

