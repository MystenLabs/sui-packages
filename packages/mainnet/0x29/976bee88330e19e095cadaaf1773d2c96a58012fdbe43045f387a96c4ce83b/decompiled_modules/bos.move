module 0x29976bee88330e19e095cadaaf1773d2c96a58012fdbe43045f387a96c4ce83b::bos {
    struct BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOS>(arg0, 9, b"BOS", b"Build On Sui", b"This is BOSBos wants to build on Sui. Build with BOS. be great and make bsc great again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwAABtbnRyUkdCIFhZWiAH4AABAAEAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAACRyWFlaAAABFAAAABRnWFlaAAABKAAAABRiWFlaAAABPAAAABR3dHB0AAABUAAAABRyVFJDAAABZAAAAChnVFJDAAABZAAAAChiVFJDAAABZAAAAChjcHJ0AAABjAAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAAgAAAAcAHMAUgBHAEJYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9YWVogAAAAAAAA9tYAAQAAAADTLXBhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABtbHVjAAAAAAAAAAEAAAAMZW5VUwAAACAAAAAcAEcAbwBvAGcAbABlACAASQBuAGMALgAgADIAMAAxADb/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAAmACcDASIAAhEBAxEB/8QAGgABAAMBAQEAAAAAAAAAAAAAAAUGCAcDBP/EADIQAAECBAQCCAUFAAAAAAAAAAECEQADBAUGBxIhExQVFhciMUFRcUJSYZGhCCcycoL/xAAXAQEBAQEAAAAAAAAAAAAAAAAFBgQH/8QAKBEAAgEDAwIFBQAAAAAAAAAAAQIDAAQRBSExUWEGEhMUcTJBgdHh/9oADAMBAAIRAxEAPwCl4mu9Tfb9W3GtmmZNnzCXPgE/CB9AGERcIveTmEOtmLJYqpRXa6Jp1V6K+VB/sR9gqOrSyR2kJdtlUVDojzyBRuTUt2TVnZp1h1zjcynmeUCQwkM/vqbve2zPHLo3hpGnSw0szeUZJzhwh1SxWtNMhrbWAz6ZhsnfvI/yfwRAWi6w13I0U3J3Hx0/FJ6jYCBFePjg/uqlZ7pWWe4S622z109VLBCZiCxDhj+DCPihD8lvFKfM6gnuKLSV0GFYikajyl6MwllPS3SumCTLn6qqomhJUSSogBgCdkgBveMvTEGXMUhX8kkgxoPIDG9HMs0vDVznS5VVJWoUmvYTUF1FL+oL+4I9II8QRvJagqMgEEgdK36U6pNvsSNvmoPtn/cbpLgz+r/B5XgfHpd+Iztqf8bRec3OjcV5U1V0oZiZ8un01FPN0lLd4BWxY7gmPVWVdrVmOb6qnkm2GVxTSEDSal2cp8NLbt8302iu/qDxvRptC8M26cifVT1JVVlBcSkJIUEk/MSBt5Ab+IgVDBcXUHslIIxk9AOc9+/3pFvVihl9ycg5x/Kz1CEIt6m669nBlsq1VtTe7bPkpoaiYVrkLcKQs7nTsxHj6NHIQSCCCxEIQTo0zzWqtIcmt2oxrHOQoxUr1jvfLct0xcuXZuFzS9H2doi0JK1pSPEloQhNUVfpGKxli3Jrq2VmVqcRNcbxUo6NS6eDJJ4i1N5lu6BsfN4QhENq2o3SXTIkhAHTaqWxtIWhDMoJNf/Z")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOS>(&mut v2, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

