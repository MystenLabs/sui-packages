module 0xfdfb4ea124a11cb74c4ee4208cd5f42dc164323f67b69812c54724532926e875::axolotl {
    struct AXOLOTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOLOTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOLOTL>(arg0, 6, b"Axolotl", b"Sui Axolotl", b"Meet Sui Axolotl, the cute and resilient crypto amphibian. Just like the axolotl regenerates, this coin is all about bouncing back and thriving in the deep waters of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Axolotl_3aeb276d1c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOLOTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXOLOTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

