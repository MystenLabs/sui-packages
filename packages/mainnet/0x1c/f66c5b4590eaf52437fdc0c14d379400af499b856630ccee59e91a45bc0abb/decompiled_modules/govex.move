module 0x1cf66c5b4590eaf52437fdc0c14d379400af499b856630ccee59e91a45bc0abb::govex {
    struct GOVEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOVEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<GOVEX>(arg0, 6, b"GOVEX", b"Govex", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRuwBAABXRUJQVlA4IOABAACQEgCdASqAAIAAPm00k0akIyGhLRiYAIANiWluA16QTQA69+xAaf29ey6o6BH7KBEr63pIUVAbXG2uv1/H8apdTJ6W3pTePLpS2zWLKroG9UXZdzwmIQV+LnGSMFk23RCokoPoau//M3k09xlZ5I0rh2BfyaOCBBlzYyiW1qWmaWYOCEWlgYHOIf6zi97rpccdcKGhnOOpVKYe79QgAP77/WfC5jncPL2jtxKsR0JBywWkBJEKBEjQBLOlm2aXoqFveb9bvZJQDz5buHIwrJ4cXcEqHD1bskQMtk++JeD2T+qUcTUNMgY8MHy80gWsDyfneI2s6nZV1eNmkw2EBPbImETuZts4jev45RH01yg+kXupzRH+o0ePPlhSr+8ZNAH9Pl9tKp/SvAiykJKaH75G5JyTM0KBjAnBoRhcRxNZJjFCMLSbvGe28+UjC0UNkIjnMbZyJ4K5SdjzF1zLEMaKDyBAQv/LIjLzeyw0mA1PrMtO8mJA0yMK5FmMivbZH/ycr3bElps7EhWD9D4yAE/37gdNeBvQH/VHIESbvJDxMXfxPjajIfMJAvzM3Zw2ksZlsz07rdFH0O72UxxgC4ePzUdeb4MJfdy+wJgkXBECes6wQAnG79EwbuIO9XAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOVEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOVEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

