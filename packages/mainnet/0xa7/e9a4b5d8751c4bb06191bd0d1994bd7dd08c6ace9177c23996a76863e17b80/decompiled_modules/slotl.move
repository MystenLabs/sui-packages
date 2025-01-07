module 0xa7e9a4b5d8751c4bb06191bd0d1994bd7dd08c6ace9177c23996a76863e17b80::slotl {
    struct SLOTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOTL>(arg0, 6, b"SLOTL", b"Suilotl", b"Hello, I am Suilotl. $SLOTL will help the market recover and regenerate in these bad days with its power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0000000_f6fd9dd78b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

