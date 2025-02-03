module 0xe0b62a1e76c420d1404b5f20100a8d2ddc08e26fa6cf63b1d07ce4cca7e6e4f1::sneeze {
    struct SNEEZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEEZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEEZE>(arg0, 6, b"SNEEZE", b"Sneezing Cat", b"That cat is sneezing crazy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sneeze_6bb8b1884c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEEZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEEZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

