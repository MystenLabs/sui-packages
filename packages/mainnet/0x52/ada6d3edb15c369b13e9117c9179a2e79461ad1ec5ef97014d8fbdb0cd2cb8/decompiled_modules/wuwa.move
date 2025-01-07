module 0x52ada6d3edb15c369b13e9117c9179a2e79461ad1ec5ef97014d8fbdb0cd2cb8::wuwa {
    struct WUWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUWA>(arg0, 6, b"Wuwa", b"WAWA & WUWA", x"574157412026205741574120697320636861726163746572207468617420636f6d652066726f6d0a6f757220696d6167696e6174696f6e2c2074686569727320676f616c20697320746f20676f20616476656e747572650a66696e64206e657720657870657269656e63652c2066616e74617379206f72206d617962652074726561737572652c0a616e64206e6f772074686579206e65656420667269656e6420746f206d616b6520746865206a6f75726e65790a6576656e206d6f72652066756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snapinsta_app_446521930_1155100332492497_6198448713442077168_n_1080_6b73a09d96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

