module 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::disc {
    struct Disc has drop, store {
        tracks: vector<0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::track::Track>,
    }

    public fun new(arg0: vector<0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::track::Track>) : Disc {
        assert!(0x1::vector::length<0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::track::Track>(&arg0) <= 50, 30);
        Disc{tracks: arg0}
    }

    public fun tracks(arg0: &Disc) : &vector<0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::track::Track> {
        &arg0.tracks
    }

    public(friend) fun tracks_mut(arg0: &mut Disc) : &mut vector<0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::track::Track> {
        &mut arg0.tracks
    }

    // decompiled from Move bytecode v7
}

