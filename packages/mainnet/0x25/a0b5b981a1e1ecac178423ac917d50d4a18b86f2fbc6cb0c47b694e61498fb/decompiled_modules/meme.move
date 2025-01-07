module 0x25a0b5b981a1e1ecac178423ac917d50d4a18b86f2fbc6cb0c47b694e61498fb::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 9, b"MEME", b"Memecoin", b"Memecoin pair Launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAMAAACahl6sAAAAn1BMVEX////jlAChRypFGDT/6E99XXF6UzzJdhH94UmoVC322UzrrhmAYXRfJTLOfA7320zKvsblnAjdjQRXLkjFp0fw7fBTKTbt1U2+eTZMHDPhtUS3YRylTCinTyeEOS7FhjmYQyv0xzC7Zhp/VF+Scmbi2+BeMkeLQy+jjZrZqkLBgDjDoUXZiQZrOTZgOEaSQS3Cch7fxEzopRDLjjllP0o7s0jnAAAB8ElEQVR4nO3dx3aCQABGYTVBYkODvWDsYolpvv+zZfvPAg8KJIPeux0OzIcsPCJDoUBERERElEmhk2HhH0LqTxlWBwIECBAgQIAAeThIS1s2pPdyuq2MQ6Xt6Lb1pE1L0ttzunX0SO0uECBAgAABAgTIfUK60nozlLYV6eclcU3t0JNOa53FbY5WW9p8zKRdVZq/Ju5TT8y+L32ddRa3fRdu6Uc8nOnVNNJLYV5M3EJ3PtCd93s6CyBAgAABAgQIkDxDwrq0nErb3Uiqad/JIUdPcgfS/tCRVjq/S/fjHeU39DRVqnqeasnnHp1nHLepxy3r/BwgQIAAAQIECJAHgBzdyI66nR9zu3+DuKXIvMgJmrlAgAABAgQIECBAroa4vnRpO9shk0Ca5BgSNyBAgAABAgQIECBAgAABAgQIECBAgKQCmYy1QIcCY8h2SODrkDHdsY74xg+oQIAAAQIECBAgQK6HLPT29CLHEP2/gDGQN0h0QIAAAQIECBAgQGJBjEeTvGK8fAsfTUo7IECAAAECBAiQO4XYtwjS4LZFkIzyvCwVECBAgAABAgSI9RArlls/JV9u3YoF8M8pLIBvovL8SgIgQIAAAQIECBDLIXfzqk2zPL/8FAgQIECAAAECxHZI6GRY7PvnRERERETX9Quy1IKn0Ii/ygAAAABJRU5ErkJggg==")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

