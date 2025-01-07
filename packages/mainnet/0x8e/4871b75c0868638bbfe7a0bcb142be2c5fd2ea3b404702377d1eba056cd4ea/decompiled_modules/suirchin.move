module 0x8e4871b75c0868638bbfe7a0bcb142be2c5fd2ea3b404702377d1eba056cd4ea::suirchin {
    struct SUIRCHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRCHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRCHIN>(arg0, 6, b"SUIRCHIN", b"SEA URCHIN ON SUI", b"born in the colorful coral reefs of the Pacific, Sui possesses a unique flavor that captivates chefs and seafood lovers alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/instant_69_f563c5ed3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRCHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRCHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

