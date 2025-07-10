module 0x7660ca85f1524493050cd1b93961a3eb8f35dc8226c8211c2e3a589849a50829::yall {
    struct YALL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YALL>, arg1: 0x2::coin::Coin<YALL>) {
        0x2::coin::burn<YALL>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<YALL>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<YALL> {
        0x2::coin::mint<YALL>(arg0, arg1, arg2)
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<YALL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YALL>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: YALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YALL>(arg0, 9, b"YALL", b"Y'all Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAdVBMVEX///8CAgIAAABra2ve3t4eHh54eHj29vYvLy9fX1/b29uEhIS9vb2srKzr6+vHx8fQ0NCioqLl5eXs7OyampqUlJQqKipZWVlOTk6GhoYTExNGRkY8PDyLi4vW1tZhYWGzs7MlJSVubm58fHwMDAwYGBhAQECTLcLtAAAE3UlEQVR4nO2bi1biMBCGS0SrpYBcRQTxxr7/I26blpKZTErWYxm75/+ORyUkaT7SZpK0JAkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACA38R+pt2CbhlujZlrN6JLpsYMzKN2KzrksRS81W5Fh8wLwYGZajfjx1lMTv9ZwSfNtnRCbsymctyUgmah3J6f56W49Mxb8c+yEByYpXZ7fp6V7bnP+iJcazenC4627w47++cxec1nk8uFesXEWLfyV/Hbkmq3SSDNhgRpXsKyZKf0RytXUclO/DozyXoiV8ihxx1+zzA3DL9BYzlLOl1uXUVjdvWkZklyPwtH/bh0zAqaa/s9Q7cfbEPvhOPQHGWDhvt1eVBHb71quv9oSHbhqHekyqDhLano/nuGyQNX5OfpkmdYVb3kJh1zJxq+sk9EmOtc1XDBu2hD30+9LiwSt+TQxU/ulPhkBQ7Khn4f0SXCiL9ddsmuvjQq5TL0O8OAdFarGiZfrEWkJrmL5+b4NBoPbawfTaxiUyJnH8nAjLUNp7yX3FPuhneIE9VLF7OrAuN54r3xDP2mXdkweRKutJoht9875b5MfQqWHX36XFIuWBTyItm1Db0z8bzjsgnLJ7PzojAtLszNOZUbeiHx2oZ2Ei16eNHSPYHLjmu69FAGEa9VwueiY+gNf6eG71oiSW7Iqreeer36gkJIvL7hlHdiepKgye7ioRhJX/yaPkXDB3VD73qr5m7HQNdWTN+EioxoyB0UDCe0ZVVvvbUMMwG8YFgXZbvFCobJXphq8aszv1gLDzxNUbYFoGHo6WR83OcTVgkhGNaFaUhUMeSjyiaRTtwLCMGwLk1DoophuXdGFVuHGZn3oCG9hnUM5/w8bWuiTGaCFdCQqGOYPIc6wNYfMczQlZahr0hIVDKUY1ldvRDc2ysoOv2WvHQ1tAwDwcy2L+beIClvbuh0l4RELcPkT+RQGIAEw+LCm5PXbkhUM5wHDKOGGRoMbZF7kuKERDVDed4cOczQYGhntjRldM6qZxiYOEcNMzQY2v2sRWjjVNHwTTCMfAQhE3TILMI5ExQN+ZrXVh01zPBgaNPGgZCoaci3nmKHGXaCm1ebltII2ZhoGrKDD2KHGRYMv+pUGkCakKhq6C2j4oYZ5lJvS9Hr+hwSdQ3H9OiRTzrR2xvn2EeTT3cKdQ0TevTIh0ho6Htv0g9iSNQ1pOt0b5sswDowByW7eM2g1UNDtjJcjRvoG/Wo1UNDdg/OuTdN0+tzvoeGLUtLal7J9M+Q36ALK856asgfBggbvvfTkN/rb1PMemkY3CYVDEeCYaje32O4/gdD4xsOjMgduxcp57KPR3Zt6K9H2hRz31DOOJLutsr1dW3YutHqteiph4bx44ytMe2doXcD2YO+P+ud4YEWuBtmlCF9EKIMif0yZMFQ+F7JgnVi1jNDvmIWstBoUjS9X4b3NP+nkGXFP4ReGbJgKH5zJuN5Anvrv9Pw+fJJyuOJudn3yZA1/kPMxB+qjVmLdGlIuLATNWehT/561zQwp2xllGxjsn3D8OHGZdWee0Fzh3qc5opjnHxE5Dr8z996BAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgOvxFxSwOKroENjlAAAAAElFTkSuQmCC")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YALL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YALL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

