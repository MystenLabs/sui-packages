module 0xf23c482c33023a31143b0e0106ccaa6482316dfb59cb3829299f938b466539c7::suircle {
    struct SUIRCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRCLE>(arg0, 6, b"Suircle", b"Suircle you look", x"596f75206c6f6f6b65642c206e6f7720796f75206d757374206170652e200a2453554952434c452072756c65732e200a0a68747470733a2f2f742e6d652f73756972636c65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3812_5fbc1c64c4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRCLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRCLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

