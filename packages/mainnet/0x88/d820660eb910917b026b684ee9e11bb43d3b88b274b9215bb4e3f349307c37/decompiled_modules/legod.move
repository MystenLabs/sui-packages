module 0x88d820660eb910917b026b684ee9e11bb43d3b88b274b9215bb4e3f349307c37::legod {
    struct LEGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGOD>(arg0, 6, b"LEGOD", b"Lego God", x"4275696c64696e672066616974682c206f6e6520626c6f636b20617420612074696d652e204c45474f44206973206120646976696e65207477697374206f6e20636c617373696320636f6e737472756374696f6e2c20626c656e64696e672074696d656c65737320776973646f6d20776974682074696d656c65737320627269636b732e204a6f696e20746865206a6f75726e657920746f20706965636520746f676574686572206d697261636c65732c206d79737465726965732c20616e64206d61796265206576656e2061206665772068656176656e6c79206c61756768732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241209_155219_923_19fedca7b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

