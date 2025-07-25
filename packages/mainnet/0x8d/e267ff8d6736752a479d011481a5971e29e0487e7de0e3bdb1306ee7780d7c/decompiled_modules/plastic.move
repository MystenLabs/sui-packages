module 0x8de267ff8d6736752a479d011481a5971e29e0487e7de0e3bdb1306ee7780d7c::plastic {
    struct PLASTIC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PLASTIC>, arg1: 0x2::coin::Coin<PLASTIC>) {
        0x2::coin::burn<PLASTIC>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PLASTIC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PLASTIC> {
        0x2::coin::mint<PLASTIC>(arg0, arg1, arg2)
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<PLASTIC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PLASTIC>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PLASTIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLASTIC>(arg0, 9, b"PLASTIC", b"Plastic Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgdmlld0JveD0iMCAwIDEwMCAxMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIxMDAiIGhlaWdodD0iMTAwIiBmaWxsPSIjMkIyQjY2Ii8+CjxwYXRoIGQ9Ik00OC44NDU1IDIzLjA1MDZDNDguNDEwNiAyMy4xMTY3IDQ3Ljk5MjIgMjMuMjUyMSA0Ny41OTcxIDIzLjQ0NjlMMjUuOTAyNiAzNC4yMzczQzI0LjczNzEgMzQuODE4NiAyNCAzNi4wMDEgMjQgMzcuMjk1N1Y1Ni4zMTk3QzI0IDU3LjYxNDQgMjQuNzM3MSA1OC44MDAxIDI1LjkwMjYgNTkuMzc4MUw0NC4zMTAxIDY4LjUzMzNDNDYuMzEyMyA2OS41MzQxIDQ3Ljg2OTUgNzIuMjI1OCA0Ni40Mzg0IDc2LjQ2MzNDNDUuMDc3MSA4MC40OTI2IDQxLjIyODkgOTAuMTUwNCA0OC44MzI0IDg5Ljk5ODJDNTUuOTQxMiA4OS44NTI5IDUyLjUxMTIgODAuMjgxNiA1MS40OTE5IDc2LjU1MjlDNDkuOTU0NiA3MC45MzQ5IDUxLjEyMzQgNjkuMjcwMyA1NS4yMjcyIDY4LjA0NzlDNTcuNzQ3MyA2Ny4xOTI1IDU5LjEyNTMgNjguNjE2IDU4Ljc0NjggNzAuMTc0OUM1OC41OTA3IDcwLjgxODkgNTcuNzAwOCA3NC4zMTMyIDYwLjIzNDMgNzQuM0M2Mi4yODk1IDc0LjI5MDEgNjIuMzMyNyA3MS40MzY1IDYxLjQ3MjcgNzAuMDgyNEM2MC4zMTA2IDY4LjI0OTMgNjEuOTcwNyA2NC45NDk5IDY0LjA0OTIgNjMuODc2NUw3My4wOTc1IDU5LjM3ODFDNzQuMjYyOSA1OC44MDAxIDc1IDU3LjYxNzggNzUgNTYuMzE5N1YzNy4yOTU3Qzc1IDM2LjAwMTEgNzQuMjYyOSAzNC44MTUzIDczLjA5NzUgMzQuMjM3M0w1MS40MDI5IDIzLjQ0MzZDNTAuNjEyNyAyMy4wNTM4IDQ5LjcxODcgMjIuOTE1MiA0OC44NDU1IDIzLjA1MDZaTTI5Ljk1MDEgMzcuNjcyQzMwLjA4OTUgMzcuNjgxOSAzMC4yMjU3IDM3LjcxODMgMzAuMzQ4NSAzNy43Nzc3TDQzLjg5NTggNDQuMjQ3OEM0Ny4yNjI1IDQ1Ljg5OTIgNTEuMjAzOCA0NS45MjI0IDU0LjU5MDUgNDQuMzEwNkw2OS4xNDMzIDM3LjUwMDJDNjkuNjc0NSAzNy4yNDkyIDcwLjMwODcgMzcuNDcwNSA3MC41NjExIDM3Ljk5OUM3MC44MTM0IDM4LjUyNDEgNzAuNTkxIDM5LjE1NDkgNzAuMDYzIDM5LjQwNkw1NS41MDY4IDQ2LjIxM0M1MS41MzU3IDQ4LjEwMjIgNDYuOTA3NCA0OC4wNzU4IDQyLjk1OTEgNDYuMTQwM0wyOS40MDkzIDM5LjY3NjhDMjguODg0NyAzOS40MTkyIDI4LjY2NTYgMzguNzg1MSAyOC45MjQ2IDM4LjI2MzJDMjkuMDUwNyAzOC4wMTIyIDI5LjI2OTkgMzcuODIwNyAyOS41MzU1IDM3LjczMTVDMjkuNjY4MyAzNy42ODUyIDI5LjgwNzggMzcuNjY4NyAyOS45NDcyIDM3LjY3ODZMMjkuOTUwMSAzNy42NzJaIiBmaWxsPSJ3aGl0ZSIvPgo8L3N2Zz4K")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLASTIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLASTIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

