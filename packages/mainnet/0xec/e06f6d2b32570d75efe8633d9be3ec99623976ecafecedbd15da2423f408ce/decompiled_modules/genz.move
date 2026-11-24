module 0xece06f6d2b32570d75efe8633d9be3ec99623976ecafecedbd15da2423f408ce::genz {
    struct GENZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENZ>(arg0, 9, b"GENZ", b"GenZ", b"Fixed 1,000,000,000 max supply GENZ token on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNTYgMjU2Ij48ZGVmcz48bGluZWFyR3JhZGllbnQgaWQ9ImJnIiB4MT0iMCIgeTE9IjAiIHgyPSIxIiB5Mj0iMSI+PHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iIzBmMTcyYSIvPjxzdG9wIG9mZnNldD0iMTAwJSIgc3RvcC1jb2xvcj0iIzFlMjkzYiIvPjwvbGluZWFyR3JhZGllbnQ+PGxpbmVhckdyYWRpZW50IGlkPSJyaW5nIiB4MT0iMCIgeTE9IjAiIHgyPSIxIiB5Mj0iMSI+PHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2YxZjVmOSIvPjxzdG9wIG9mZnNldD0iNTAlIiBzdG9wLWNvbG9yPSIjOTRhM2I4Ii8+PHN0b3Agb2Zmc2V0PSIxMDAlIiBzdG9wLWNvbG9yPSIjY2JkNWUxIi8+PC9saW5lYXJHcmFkaWVudD48L2RlZnM+PHJlY3Qgd2lkdGg9IjI1NiIgaGVpZ2h0PSIyNTYiIHJ4PSIxMjgiIGZpbGw9InVybCgjYmcpIi8+PGNpcmNsZSBjeD0iMTI4IiBjeT0iMTI4IiByPSIxMTIiIGZpbGw9Im5vbmUiIHN0cm9rZT0idXJsKCNyaW5nKSIgc3Ryb2tlLXdpZHRoPSIxMiIvPjxjaXJjbGUgY3g9IjEyOCIgY3k9IjEyOCIgcj0iOTUiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzI1NjNlYiIgc3Ryb2tlLXdpZHRoPSIzIi8+PHRleHQgeD0iMTI4IiB5PSIxNTAiIHRleHQtYW5jaG9yPSJtaWRkbGUiIGZvbnQtZmFtaWx5PSJBcmlhbCxzYW5zLXNlcmlmIiBmb250LXdlaWdodD0iODAwIiBmb250LXNpemU9Ijg4IiBsZXR0ZXItc3BhY2luZz0iNCIgZmlsbD0iIzNiODJmNiIgc3Ryb2tlPSIjZTJlOGYwIiBzdHJva2Utd2lkdGg9IjIiPkdaPC90ZXh0Pjwvc3ZnPg==")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<GENZ>>(0x2::coin::mint<GENZ>(&mut v2, 1000000000000000000, arg1), @0x628c9a988a4bac6f38d13517a2b7ca5203213f6543de9f6c545c0d5c11320733);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GENZ>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENZ>>(v1);
    }

    // decompiled from Move bytecode v7
}

