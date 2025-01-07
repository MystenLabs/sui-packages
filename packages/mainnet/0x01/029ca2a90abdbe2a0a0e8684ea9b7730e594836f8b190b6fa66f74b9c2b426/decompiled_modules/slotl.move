module 0x1029ca2a90abdbe2a0a0e8684ea9b7730e594836f8b190b6fa66f74b9c2b426::slotl {
    struct SLOTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOTL>(arg0, 6, b"SLOTL", b"Suilotl", x"48656c6c6f2c204920616d205375696c6f746c2e0a0a24534c4f544c2077696c6c2068656c7020746865206d61726b6574207265636f76657220616e6420726567656e657261746520696e20746865736520626164206461797320776974682069747320706f7765722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_15_48_58_062bd4e9a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

