module 0x73968f2b05703f135760d1161dc40b3c9c2cd0c7e72169ca787c86981ce306e::iko {
    struct IKO has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<IKO>, arg1: 0x2::coin::Coin<IKO>) {
        0x2::coin::burn<IKO>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<IKO>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKO>>(arg0, @0x0);
    }

    fun init(arg0: IKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKO>(arg0, 6, b"IKO", b"IKO Network", b"IKO NETWORK. Observe. Watch. Learn. Advanced AI-powered MPC protocol for autonomous multi-chain asset management with IKO neural assistant.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAwIiBoZWlnaHQ9IjEwMDAiIHZpZXdCb3g9IjAgMCAxMDAwIDEwMDAiIGZpbGw9Im5vbmUiPiA8cmVjdCB3aWR0aD0iMTAwMCIgaGVpZ2h0PSIxMDAwIiBmaWxsPSIjRUUyQjVCIi8+IDxwYXRoIGQ9Ik02NzguNzQyIDU4OC45MzRWNDEwLjQ2N0M2NzguNzQyIDMxMS45MDIgNTk4Ljg0IDIzMiA1MDAuMjc1IDIzMlYyMzJDNDAxLjcxIDIzMiAzMjEuODA4IDMxMS45MDIgMzIxLjgwOCA0MTAuNDY3VjU4OC45MzQiIHN0cm9rZT0id2hpdGUiIHN0cm9rZS13aWR0aD0iNTcuMzIyOCIvPiA8cGF0aCBkPSJNNjc4Ljc0OCA1MjkuNDQxTDY3OC43NDggNTk4Ljg0NUM2NzguNzQ4IDYzNy4xNzYgNzA5LjgyMiA2NjguMjQ5IDc0OC4xNTIgNjY4LjI0OVY2NjguMjQ5Qzc4Ni40ODMgNjY4LjI0OSA4MTcuNTU2IDYzNy4xNzYgODE3LjU1NiA1OTguODQ1TDgxNy41NTYgNTI5LjQ0MSIgc3Ryb2tlPSJ3aGl0ZSIgc3Ryb2tlLXdpZHRoPSI1Ny4zMjI4Ii8+IDxwYXRoIGQ9Ik01NzMuNDkxIDc2OC45MThMNTczLjQ5MSA2NjMuMTU5QzU3My40OTEgNjIyLjcyMyA1NDAuNzExIDU4OS45NDIgNTAwLjI3NCA1ODkuOTQyVjU4OS45NDJDNDU5LjgzNyA1ODkuOTQyIDQyNy4wNTYgNjIyLjcyMyA0MjcuMDU2IDY2My4xNTlMNDI3LjA1NiA3NjguOTE4IiBzdHJva2U9IndoaXRlIiBzdHJva2Utd2lkdGg9IjU3LjMyMjgiLz4gPHBhdGggZD0iTTE4MyA1MjkuNDQxTDE4MyA1OTguODQ1QzE4MyA2MzcuMTc2IDIxNC4wNzMgNjY4LjI0OSAyNTIuNDA0IDY2OC4yNDlWNjY4LjI0OUMyOTAuNzM1IDY2OC4yNDkgMzIxLjgwOCA2MzcuMTc2IDMyMS44MDggNTk4Ljg0NUwzMjEuODA4IDUyOS40NDEiIHN0cm9rZT0id2hpdGUiIHN0cm9rZS13aWR0aD0iNTcuMzIyOCIvPiA8cGF0aCBkPSJNNTAwLjI3MiAzNzAuNzk4QzUzMy4xMjcgMzcwLjc5OCA1NTkuNzYxIDM5Ny40MzMgNTU5Ljc2MSA0MzAuMjg4QzU1OS43NjEgNDYzLjE0MiA1MzMuMTI3IDQ4OS43NzcgNTAwLjI3MiA0ODkuNzc3QzQ5NC4xNzQgNDg5Ljc3NyA0ODguMjkgNDg4Ljg1OCA0ODIuNzUxIDQ4Ny4xNTNDNDkzLjA4MiA0ODIuNDkgNTAwLjI3MiA0NzIuMSA1MDAuMjcyIDQ2MC4wMjlDNTAwLjI3MiA0NDMuNjAyIDQ4Ni45NTUgNDMwLjI4NSA0NzAuNTI4IDQzMC4yODVDNDU4LjQ1OCA0MzAuMjg1IDQ0OC4wNjcgNDM3LjQ3MyA0NDMuNDA0IDQ0Ny44MDJDNDQxLjcwMSA0NDIuMjY1IDQ0MC43ODMgNDM2LjM4MyA0NDAuNzgzIDQzMC4yODhDNDQwLjc4MyAzOTcuNDMzIDQ2Ny40MTcgMzcwLjc5OCA1MDAuMjcyIDM3MC43OThaIiBmaWxsPSJ3aGl0ZSIvPiA8L3N2Zz4=")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<IKO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<IKO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

