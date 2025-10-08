module 0xbf8a53ca4385246c6e466ca88c49cb443b5218a2d7d44753afaffbf88d72bbfa::lgt {
    struct LGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<LGT>(arg0, 6, b"LGT", b"lighter", b"test ligth token", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRsABAABXRUJQVlA4ILQBAADwDQCdASqAAIAAPm02lkekIyIhKJaYKIANiWlu3QnzPQLdwO0BBAcoNmbfF/8t7AfSM9EYZ3Qw7la9yari6HVyU4GA0zs5Y6FhAVnwsufXfYeatF2ekG12oSGulxDlHL+2CNcoARN723lEfjjUBfMFtUg3UOF8AAAA/vsaNtxQIWInauX2/jr+YLOhfJK39A/O/J/tYWHVPjDZx/474AjvCoAB65SwGzT01aALKzoF1GUb0Tp62Ez2IJxzbtk9+fUDgQwGdCdXLD9lYWUJIqOTOBw8zhEVo4Jds/nF2yPryje7afXWCzxJYWUcZNZ1Oyynfy/Qc2NuTS9zAVnGEfIqYsXBZi28LAH3k4hGFRJGHIeMXTRE51x9axV8UXyfPGOmABYy4m7oQ5X+UHjSvpNDXdMX3dLzaKq8yxlauWDbEAV1bZanLVs0kAUmDn84CWYoXrx0hIn+6ubDdkA7hYEtPPRdU+GcTf3y0f+gliBHPvLxkZCb/x5jH/gGO/bs8gBsERe2gYDTkvWp3sI9PPqQ9cW0xCwz30MYqmrGDCTt/OdufKoqMrP3VOSB5aoMG8XAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

