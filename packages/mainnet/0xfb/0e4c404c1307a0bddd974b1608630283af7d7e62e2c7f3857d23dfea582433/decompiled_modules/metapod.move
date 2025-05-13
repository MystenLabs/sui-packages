module 0xfb0e4c404c1307a0bddd974b1608630283af7d7e62e2c7f3857d23dfea582433::metapod {
    struct METAPOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: METAPOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<METAPOD>(arg0, 6, b"METAPOD", b"Metapod", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADgAAAA4AgMAAADV6NONAAAAAXNSR0IB2cksfwAAAAlwSFlzAAAK6wAACusBgosNWgAAAAxQTFRF+Pj4SHAIAAAAePgAO4HJjQAAAQNJREFUeJxjZEABjKNcLNyEBchcJrYfyFwWq0PIXI5vTMhcgbfNDUhc5UvdyFznTdkLkLj96asSEFwm3lf/OZC5l+84IbjcLcJfXjXAuZxPuQTjZ8C5HO/Zl99sgnP1lmhHcDkmwLmmMdOYFnLAuFvP5aQxLEbiVkQxcC+AcTWzMm41ajXAnZHb8GwywiKG9Q7PDmcguLtZxJpXILj7HK8hc/UuonD1J0z7vwaF+3sDChfkCgg3YMPagAi4LKP5qTvyEdow7zOduZP4KuH1ARjXcVZi+NFl8LDaMHFPrF8EnDtf4dqF34hgVy24ovsKESlMyR+DwxkQ4byKYdoBJC4coHEBz91YOWHOAWIAAAAASUVORK5CYII="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METAPOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<METAPOD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

