module 0x1ddb083d76d52b11ea0ed7c0b88281e0547a1e588e18edbe4ac37783fafa51a0::whale_helpers2 {
    struct ParkMarker has store, key {
        id: 0x2::object::UID,
        labeled_for: address,
    }

    struct ParkMarkerCreated has copy, drop {
        marker_id: address,
        target: address,
    }

    public entry fun create_park_marker_for(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ParkMarker{
            id          : 0x2::object::new(arg1),
            labeled_for : arg0,
        };
        let v1 = ParkMarkerCreated{
            marker_id : 0x2::object::id_address<ParkMarker>(&v0),
            target    : arg0,
        };
        0x2::event::emit<ParkMarkerCreated>(v1);
        0x2::transfer::public_transfer<ParkMarker>(v0, arg0);
    }

    public fun park_marker_labeled_for(arg0: &ParkMarker) : address {
        arg0.labeled_for
    }

    public fun split_off(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg2)
    }

    public entry fun vector_oob_abort() {
        let _ = vector[];
    }

    // decompiled from Move bytecode v7
}

