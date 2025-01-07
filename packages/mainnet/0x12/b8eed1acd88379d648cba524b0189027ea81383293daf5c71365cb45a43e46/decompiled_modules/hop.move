module 0x12b8eed1acd88379d648cba524b0189027ea81383293daf5c71365cb45a43e46::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOP>(arg0, 6, b"HOP", b"Hop Bunny", b"First bunny on Hop.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/imgres?imgurl=https%3A%2F%2Fpbs.twimg.com%2Fprofile_images%2F1827504876110188544%2FG9NH_V7z_400x400.jpg&tbnid=G-MSJprrWHbKWM&vet=1&imgrefurl=https%3A%2F%2Ftwitter.com%2Fhopaggregator&docid=30LG-gFbDWoUiM&w=400&h=400&hl=en-us&source=sh%2Fx%2Fim%2Fm1%2F3&kgs=321b356ea68a812f&shem=abme%2Ctrie")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<HOP>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<HOP>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

