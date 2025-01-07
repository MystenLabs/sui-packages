module 0xc9caeb560861381d4e1a7d504e218e4d5bab5026e3c44390db839e45c27b751f::satoshi {
    struct SATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHI>(arg0, 9, b"SATOSHI", b"Satoshi on SUI", b"The one and only Satoshi Nakamoto, on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxAQEBUQEBIVFRUVFRUVFRUVFRAVFRUVFRUXFhYVFxYYHSggGBolGxYVITEhJSkrLi4uFx8zODMtNygtLisBCgoKDg0OFxAQGi0dHR0tLS0rLS0tLS0tLSsrLS0tLS0tLS0vLS0tLS0tLSstLS0rLSstLS0tLS0tLS0rLSsrK//AABEIAKIBNwMBIgACEQEDEQH/xAAbAAABBQEBAAAAAAAAAAAAAAAAAQIEBQYDB//EAD0QAAEDAgQDBQYEBAUFAAAAAAEAAhEDIQQFEjFBUWEGInGBkRMyobHR8CNCUsEUYoLhBxVyovEzU3OS4v/EABkBAAMBAQEAAAAAAAAAAAAAAAABAgMEBf/EACIRAQEAAgICAgIDAAAAAAAAAAABAhEDITFBElEiMgQTof/aAAwDAQACEQMRAD8A5twy6tw6ntpJ4pLndSCKCeKCnCkl9kgJOSUoWroiyz2UsWjpbK8WeRwCcEBCpBpTE9yYlQVKE1OCQCVIlQAhCRAKmudCVccW8hpjf5cyihn8dm/fIHC0yBtyJ2vxF+oSYPMWkiatzsAXCfA3LvFYzN88Y1+nukSWtbPvGY25T985eT+0qHW+JMHS2Ghoj8xPDossd2tL4bpoJuKjiP8AWCPCAo1XHhh0uAcORPLoRCh0sZTpC5mImNQaBw7xhpVZie0eHJIgk8ADI9SACPAromojVq2/zkkw2n0/Kb/0lJia7QNdX2TBH6jJPjx9FRDNnOswCnzdpYT4AmfgmYTANxNTUWPfwLnl1+gE/Mx0Rc4qcdpczxgxEMZ7v6iIE8wGxHiqbGdmKunU1oe0jvUwY1O/VT/S7pxXoGCyBjR7oHmSjEZc5kwLGecdFhlndt5xTTySplxE+85o4Ed9h5FpuDG4m8cdlyFGrTc72Lg5pNhvblpIsvUq+Igg1KDXgCCbarciWn0lVuIwGCrXY0UyeFhPOBx9VrhnK")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SATOSHI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

