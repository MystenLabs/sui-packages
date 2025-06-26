module 0xb7aa0e3788186cb10863594c7daaa5f8d408ee882085a76b4dfaa03f1f64f693::ask {
    struct ASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<ASK>(arg0, 0, b"ASK", b"akldsfj", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRnwEAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBgAAAABDzD/ERGCTNpGSv073BcVg4j+xwCA/h5WUDggPgQAAHAaAJ0BKoAAgAA+bTaXSKQioiEjm2kggA2JZwDSkXo9Hn0MUv/x3sZfsB7AH63etv6pH+syY9OPocvDPtFlE3uH5T8gO0bvBnGP5V9zPm2/pvoZ3jP5v/fOPmoAfyf+if5v0385D0//w/cF/k39W/6HYHF7nq/4xySzo64zZKxIvINVftFRIMLDm25z6aXgKmTF0BYbydMjn1U9HwZoaNqPmjdL4DYIHxR0aaWBgOdJwqoRptRElUcPrwgbu3ADdb1FqcK+0RwPVM4o4AxIE6vaQC3dZvQhpmM1+QAA/vwNfXu/lmAKZs/doZMIxb/HPGje6lbsrtR7zscLA5/PT+QlP+E4xkcXuwzc5O/3AP0OqcdUzw/+N7jS3A3lhwelbW6tXV0xC3a9pcXHHfZhQzQX46BlDVj3VdSBiJn/wR43/mLejA6bJS3O0M+I75JsvLEnd2w1IX4Nn04/3M6hCqTQOqd0EV7E9WskSVYEk4AjLZ3eR3CVSG2rcykFe4otLpCg3iSwaU2NpsY81xnsL685WH/sTUP+O82wKIlR/S60b+OYvEfS6hNnx8VB8wmly9PODWy7Hgx3AYcx2wjBwJzPtMWeGLWZ1D4r13RItDOlv+XFneCeKPfmCUIZ8P51yueezefW0Mq3prMhsSwPq9AngHVXU/emZsA1KnUuP4zjTaThbXy34n8wqUPncNqNKMlsvp99ioBqRBEPFiZDd/IluoPNv8t9mv7K+74+May8j9HEieK+pQOBDaSu5J3EByWhRDl7D7hHu3r7vo05cVLz2Ji1xuePtJhPF8/2rJsEiLxuuYnVbmv1PcjB4gIgKCPitP4x4e3TqYwnRddp71MXhwHl4pnxTEfci93+fo5sLV0o/OGw9CdzyLh1kBGvAGIoROdsEQkZJuNv0p0XWGdXiogNiPV8fv2AGC3y/+cgyMWFSekc4hWka6vPeY8xrEjnLO4Z+VkyOkVyYWH8ZgBAuVyDZqt+fRpbh1r7y5RlhNHAyQhnhH2Ikto2q4lgCmaFnKjY6x/GNqnEifsrA0IfNhed3GJE0XUW0OlWGcLHJ/54YcJxc2RYqSo8T3a9jRascFdeWi4zyunuRiyqXRP/5jMCDmmF+Wk/2rYfHjgX2YHFyFm9rD1yGi4tR/Znzz59vhVAAx/jdQNEEyNW5x0mP12GcvfLMwS5Ttn+dEeUxTi4DW/UlbowfHn9ul2oWdMcDLTu7SdETyzgNrlvnthvWyKnrXWM0vi4xPLuuNFti0r3BNFjTJMzS6rV2ntdRj9adh+SnnXKMEH6WDSu5cqmvj6T5Neb1fsotfdu7/x0pOywtT1eGlqTb/ijee3N6q5/GtaSl0fcATRlMhoFnXv8VXC71cfhBBaJilwCNSzkCAi/RbznlWNtFjIVacLQPSM7OhE7zrbbcy4hvXdAUO4v/DTsVGhAiCEFdwAAAA=="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

