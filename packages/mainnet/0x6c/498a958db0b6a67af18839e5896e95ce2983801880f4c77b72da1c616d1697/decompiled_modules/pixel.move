module 0x6c498a958db0b6a67af18839e5896e95ce2983801880f4c77b72da1c616d1697::pixel {
    struct PIXEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<PIXEL>(arg0, 6, b"PIXEL", b"Pixel coin", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRngEAABXRUJQVlA4IGwEAADQHQCdASqAAIAAPm0wkkYkIyGhLhW7UIANiUAaoEgP27Xiu5fkRzhezfgjoBpA86Pjn/Jeff1c+YB+PHUt8wH6cfsz7rHSAf1X+gdbX6Dv7Gek9+43w0/uB6QmqfXb6kT592ytA0dhzMvpav+qKtI24tqXF2hK25Bo+p4HBtYGxrMuGSeT9UZMjOJdMbOU63MalFE/Iwujg1slgGilsMVOHe2JUyrA6njJ8Pucc9/l4pj7+6SmFfCVp1+uFLOWAx9SyD4tzYv7mC6MHR3U2TrfpY+uBKfPykED5ZeHStR2E7u9yCPVbcXv2e/rybEQ9H5xr+MbrZwAAP78dnnmucZkRIqcZ/zNMR8EHF1YNGDi1gzFXM0bQpVbEmiWAG4EQJSpnKbI4XOxM4G7f/WiEewqCefim8A7cyxsm8Oyb3MwzHnvEjnqHm1OAYP2/D/gK6e5r0fBbAkYRWT8SuGQoVY1BvvHJO65JkKFcvllcEluJr3fUI178kHe8EtG1181tRsvsXfX9Rm2+A9bs/YYSyFrHUAXnfd8Rn+NTrjHp9VnXRQE67PMkfOeXf/lcrtdzUzodi6mpObZ5r/cYHB0IoZB+1aACsLY8MXUotsCq/3aYIn6aSE/M5XZHGEFZr8Q/V1+/sFgWkqtBifiP/4ut7JabKqPI0IG0lmoLVLG+2DYqm94mOD6OAPyU1/UIXH46rIoOZmc7vNhyfVPQ4Gy57KxnXbKQYfFNjN/w3JO4tJko/luYKljyziSaih7jlRN9giYzwHjH+/q8ZjiEbZx2lfkhAF9wYHliLACBW3mf5zBugu6/4OgfQ7OoPiu48loqTXwb4vnNKdcKFQmFVNC+Gg35/gwB5seDT4W+PazzjIiSbTDXeMLlB013+SWECAI8qBoLBDrS+s4UfqYFy3f5Tlg+AS01h38xSn7cgJmmC1qnLUSUb7tKupk+KclvffrA6UQlMLvfr5bPcabmDf4ip6CI+PK5PmdH4sLP5ylCH8Ev3thcaP54P5Ah8Y2QayWMYCQ5mf0rZ6uWofsPw7mTwIGtNqSHrTTloa+VdABYGEZY/IO0Dkl8+zx2k6QT5iOAsCWpexvxTyAT0lHEr0t8KlO2b8Hg6B9ChP911O3ZxaljcafkZ0Dqv9UfGl8LJa3XWx4ky2TUqp2guvHLX8o/vftaOlPOc0Z21Sdy7vnV/ZIz6W/nrzbu4YFl0sd6Upg4a/36tgLhxWz9/Q46gvaHbqtqfkB8tKiWkHwCeNu+V/n+nMPhT5LV+M36e5DkePiMYs/z7PWweh9/u4nxh7uI0Rvm3BLR2n1Hppwwtt9XrnzP+LdzzSOWYOlzzC2n7h8Svv63/WnHT+HxfZ3S85Rbh3+9cDhl6MAlGABpnQvzn82IHPMY4g5VLM4EDSL4kWvUn/EIurvTLNSKc772r02stpGq4nvFrvMe6uUPIgeJ+4au91chyqGBFWSVIW+/sH0fsV3qf2LFpfMCGKuo+m+2ZKdcXO/vUz80SRgAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIXEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

